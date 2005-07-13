Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVGMXos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVGMXos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGMXn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:43:58 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:17071 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262652AbVGMXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:40:56 -0400
Date: Thu, 14 Jul 2005 03:40:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: John Rose <johnrose@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: pci_size() error condition
Message-ID: <20050714034019.B25768@jurassic.park.msu.ru>
References: <1121295192.23038.15.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1121295192.23038.15.camel@sinatra.austin.ibm.com>; from johnrose@austin.ibm.com on Wed, Jul 13, 2005 at 05:53:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 05:53:13PM -0500, John Rose wrote:
> Before a recent change, mask was a 64-bit number.  The second part of
> the if statement would always resolve to true, since the 32-bit bitop
> would never equal the 64-bit mask.  So the second part of the if
> statement was ineffectual up until very recently.

It was always effectual for IO where the mask is 0xffff.

Ivan.
