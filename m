Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVJLQLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVJLQLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVJLQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:11:19 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:39339 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932373AbVJLQLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:11:18 -0400
Subject: Re: modalias entries for ccw devices
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051012154844.GA10587@wavehammer.waldi.eu.org>
References: <20051012141218.GA4039@wavehammer.waldi.eu.org>
	 <1129127818.32420.2.camel@localhost.localdomain>
	 <20051012154844.GA10587@wavehammer.waldi.eu.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 18:11:12 +0200
Message-Id: <1129133472.32420.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 17:48 +0200, Bastian Blank wrote:
> > No, but as far as I can tell after glancing at the modalias
> > implementation in usb this would make sense for ccw as well.
> 
> Hmm, I don't find device tables in ctc.ko and lcs.ko, can that be fixed
> at the same time?

That is because ctc and lcs are group device drivers. The ccw device
driver is the cu3088 driver. You'll get an lcs/ctc device by "grouping"
two of the cu3088 device together.

> Hmm, something else. Wasn't there a cu type or device type clash between
> escon and lcs, or was that only related to chan types reported by the
> 2.4 kernels?

Yes, the 2.6 group devices have emerged from the 2.4 chandev devices
(and thank god that we got rid of that junk).

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


