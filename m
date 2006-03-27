Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWC0Tre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWC0Tre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWC0Trd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:47:33 -0500
Received: from [81.2.110.250] ([81.2.110.250]:13514 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751447AbWC0Trd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:47:33 -0500
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Douglas Gilbert <dougg@torque.net>,
       Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603270936290.15714@g5.osdl.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
	 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
	 <4427FEC9.4010803@torque.net>
	 <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org>
	 <20060327172530.GH3486@parisc-linux.org>
	 <Pine.LNX.4.64.0603270936290.15714@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 20:54:47 +0100
Message-Id: <1143489287.4970.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-27 at 09:43 -0800, Linus Torvalds wrote:
> The fact is, BUS/ID/LUN crap really doesn't make sense for the majority of 
> devices out there. Never has, never will. The fact that old-fashioned SCSI 
> devices think of themselves that way has absolutely zero to do with 
> reality today.

It is still a very visible reality if you work in a data centre or with
server kit, or if you have tape arrays or multi-CD towers. The LUN or
device number in particular are generally the number emblazoned on each
slot in the unit and knowing the LUN reliably is sort of critical to not
making embarrasing (and career limiting) screwups when swapping drives.

Controller is a pretty abstract concept and except on arrays so is
device, but both device and LUN do need to be accessible reliably for
the hardware that thinks that way. What other hardware does is
irrelevant and "-EINVAL" seems as good an answer as anything.

Alan

