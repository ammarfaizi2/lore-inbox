Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWALO7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWALO7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWALO7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:59:53 -0500
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:62344 "EHLO
	email.studentenwerk.mhn.de") by vger.kernel.org with ESMTP
	id S1030439AbWALO7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:59:52 -0500
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Organization: Studentenwerk =?iso-8859-1?q?M=FCnchen?=
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Thu, 12 Jan 2006 15:59:30 +0100
User-Agent: KMail/1.7.2
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <43C64B0C.2080903@trash.net> <1137072707.5013.7.camel@localhost.localdomain>
In-Reply-To: <1137072707.5013.7.camel@localhost.localdomain>
Cc: Patrick McHardy <kaber@trash.net>, bluez-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, maxk@qualcomm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601121559.31203.wolfgang.walter@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

> so it seems that Broadcom really messed the SCO MTU settings up and we
> have to workaround with some sane values.

Maybe flow control for SCO must be explicitly switched on on broadcom? It 
seems that one can switch on and off flow control for SCO (but switched off 
completion events should not be sent at all).

There is another thing with flow-control in in bluez: as far as I see the code 
assumes to get a completion event for every packet submitted to the 
controller. But this is not necessarily the case. A HCI_EV_DISCONN_COMPLETE 
for a connection implicitly completes all packets of that connection.

I don't know if any controller uses this feature, though.

>
> Please also include the lspci for these devices.
>

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
Leiter EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196 276
Fax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
