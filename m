Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWAQXjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWAQXjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWAQXjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:39:41 -0500
Received: from free.wgops.com ([69.51.116.66]:2064 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932393AbWAQXjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:39:40 -0500
Date: Tue, 17 Jan 2006 16:39:35 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>, Benjamin LaHaise <bcrl@kvack.org>
Cc: Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <A1F2470FFF6F1B84CEF78FC4@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
 <20060117193913.GD3714@kvack.org>
 <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 17, 2006 9:13:49 PM +0100 Martin Drab 
<drab@kepler.fjfi.cvut.cz> wrote:

> I've consulted this with Mark Salyzyn, because I thought it was a problem
> of the AACRAID driver. But I was told, that there is nothing that AACRAID
> can possibly do about it, and that it is a problem of the upper Linux
> layers (block device layer?) that are strictly fault intollerant, and
> thouth the problem was just an inconsistency of one particular localized
> region inside /dev/sda2, Linux was COMPLETELY UNABLE (!!!!!) to read a
> single byte from the ENTIRE VOLUME (/dev/sda)!

Actually...this is also related to how the controller reports the error. 
If it reports a device level death/failure rather than a read error, Linux 
is just taking that on face value.  Yup, it should retry though.  Other 
possibilities exist including the volume going offline at the controller 
level, having nothing to do with Linux, this is most often the problem I 
see with RAIDs.
