Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbSLLIuF>; Thu, 12 Dec 2002 03:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbSLLIuF>; Thu, 12 Dec 2002 03:50:05 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:11282 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S267441AbSLLIuE>;
	Thu, 12 Dec 2002 03:50:04 -0500
Message-ID: <3DF84F8F.1090606@epfl.ch>
Date: Thu, 12 Dec 2002 09:57:51 +0100
From: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Dawes <dawes@XFree86.Org>
CC: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org,
       davej@suse.de, faith@redhat.com, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no> <3DF72A91.5080804@epfl.ch> <20021211205854.A7654@xfree86.org>
In-Reply-To: <20021211205854.A7654@xfree86.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Dawes wrote:

> 
> No, I think it should be intel_845_setup too, since the 845G docs on
> Intel's public web site show that the behaviour is like the 845 when
> the on-board graphics isn't enabled.  I made that change in my
> locally maintained version of the agpgart driver a little while ago,
> but haven't had the opportunity to test it with an external AGP card
> in an 845G box yet.

Damn, you're right. Now I got the docs from Intel (at the time were the 
patch to support 845g was submitted, they were just not available yet), 
and truly the specs are closer to the 845, so let's switch to 
'intel_845_setup' to initialize the 845g. Not that it should change 
things too much, but it will avoid further confusions....

Best regards.

Nicolas

PS: I hope the IBM annoyances for mails sent to lkml stopped...
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

