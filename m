Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266041AbUAFA7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUAFA7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:59:34 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:7659 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S266041AbUAFA7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:59:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Relocation overflow with modules on Alpha
References: <yw1xy8sn2nry.fsf@ford.guide>
	<20040106004435.A3228@Marvin.DL8BCU.ampr.org>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 06 Jan 2004 01:59:30 +0100
In-Reply-To: <20040106004435.A3228@Marvin.DL8BCU.ampr.org> (Thorsten
 Kranzkowski's: 44:35 +0000")
Message-ID: <yw1xu139zybx.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Kranzkowski <dl8bcu@dl8bcu.de> writes:

> On Mon, Jan 05, 2004 at 02:21:37AM +0100, Måns Rullgård wrote:
>> 
>> I compiled Linux 2.6.0 for Alpha, and it mostly works, except the
>> somewhat large modules.  They fail to load with the message
>> "Relocation overflow vs section 17", or some other section number.
>> I've seen this with scsi-mod, nfsd, snd-page-alloc and possibly some
>> more.  Compiling them statically works.  What's going on?
>
> I saw a similar thing, but I'm compiling everything statically:

I want the modules.

> : relocation truncated to fit: BRADDR .init.text
> init/built-in.o(.text+0xf10): In function `inflate_codes':
>
> Disabling a not so important subsystem (sound) helped for the time being.
>
> It seems my kernel crossed the 4 MB barrier in consumed RAM and possibly
> some relocation type(s) can't cope with that. Time to use -fpic or 
> some such?

I didn't think of that.  Where's the proper place to set such things?

-- 
Måns Rullgård
mru@kth.se
