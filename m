Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWIDM02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWIDM02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIDM02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:26:28 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:22217 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964834AbWIDM01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:26:27 -0400
Message-ID: <44FC1D03.1080403@student.ltu.se>
Date: Mon, 04 Sep 2006 14:33:07 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven French <sfrench@us.ibm.com>
CC: akpm@osdl.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org,
       sfrench@samba.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Converting into generic boolean
References: <OF54100A15.CFE2FA3E-ON872571DC.0073878E-862571DC.0073AAFB@us.ibm.com>
In-Reply-To: <OF54100A15.CFE2FA3E-ON872571DC.0073878E-862571DC.0073AAFB@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.

Steven French wrote:

> If bool is really more efficient (not just better for typechecking at 
> compile time), I don't mind checking in a set of such changes post 2.6.18
>
Efficient how? Memory, cpu-cycles, man-hours? The latter I think is 
quite hard to prove one way or the other.
The first two depends on the compiler and its settings. I prefer a small 
memory-consumption so there is less swapping, others try to pull out 
every possible cpu-cycle. Giving the compiler information about what 
type we are really using, should let it make the result more efficient 
in either our preference, then any micro-optimization.
Also statements like:
a = !!b;
can be optimized to just plain:
a = b;

>
> Steve French
> Senior Software Engineer
> Linux Technology Center - IBM Austin
> phone: 512-838-2294
> email: sfrench at-sign us dot ibm dot com
>
> Richard Knutsson <ricknu-0@student.ltu.se> wrote on 09/01/2006 
> 08:42:58 AM:
>
> > Jan Engelhardt wrote:
> >
> > >>--- a/fs/cifs/asn1.c   2006-09-01 01:24:45.000000000 +0200
> > >>+++ b/fs/cifs/asn1.c   2006-09-01 02:43:09.000000000 +0200
> > >>@@ -457,7 +457,7 @@ decode_negTokenInit(unsigned char *secur
> > >>unsigned char *sequence_end;
> > >>unsigned long *oid = NULL;
> > >>unsigned int cls, con, tag, oidlen, rc;
> > >>-   int use_ntlmssp = FALSE;
> > >>+   int use_ntlmssp = false;
> > >>    
> > >>
> > >
> > >Should not this become 'bool use_ntlmssp'? Possibly in a later patch?
> > >  
> > >
> > I would like to, but there has been complaints on changing 'int''s into
> > 'bool''s, so until there is a more formal decision on this...
> > Of course I would be happy to make a 'int'->'bool'-patch if a 
> maintainer
> > wants it.
> >
> > >
> > >Jan Engelhardt
> > >  
> > >
> > Richard Knutsson
> >
>


-- 
VGER BF report: U 0.46053
