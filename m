Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVCXBjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVCXBjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVCXBjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:39:51 -0500
Received: from alt.aurema.com ([203.217.18.57]:33432 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262303AbVCXBjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:39:42 -0500
Date: Thu, 24 Mar 2005 12:29:48 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
Subject: Re: read() on relayfs channel returns premature 0
Message-ID: <20050324012948.GC25134@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
References: <20050323090254.GA10630@aurema.com> <16961.35656.576684.890542@tut.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <16961.35656.576684.890542@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2005 at 09:29:12AM -0600, Tom Zanussi wrote:
> kingsley@aurema.com writes:
>  > 
>  > Now I understand that this is not the latest release of relayfs (there
>  > are the redux patches, which I have yet to try).  Nonetheless I'd like
>  > to know whether this behaviour is deliberate.  Is it? 
> 
> Nope, looks like you've found a bug - thanks for the patch.  Any
> chance you can send me your module so I can easily reproduce the
> problem and test the fix?
> 
> Thanks,
> 
> Tom
> 

Tom,

Yes, well a cut down version of the kernel module anyway.  Its in the
attached tar ball.  The kernel module requires pagg as well as relayfs
to work.  Basically the module tracks kernel events - in this case
process execs.  

I've tested it on 2.6.10 with the pagg and relayfs patches from

http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-2.6.10-050113 

and

ftp://oss.sgi.com/projects/pagg/download/linux-2.6.10-pagg.patch-4

read() gives me a zero still once about a page of data has been read.

Many thanks, 
--
		Kingsley

--Dxnq1zWXvFF0Q93v
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="RelayfsModule.tar.bz2"
Content-Transfer-Encoding: base64

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

--Dxnq1zWXvFF0Q93v--
