Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312425AbSDCW3u>; Wed, 3 Apr 2002 17:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312420AbSDCW3k>; Wed, 3 Apr 2002 17:29:40 -0500
Received: from [12.150.248.132] ([12.150.248.132]:52786 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S312425AbSDCW30>; Wed, 3 Apr 2002 17:29:26 -0500
Date: Wed, 3 Apr 2002 16:28:10 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Eric Sandeen" <sandeen@sgi.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] kmem_cache_zalloc()
Message-Id: <20020403162810.2c24ba60.reynolds@redhat.com>
In-Reply-To: <1017871982.25556.7.camel@stout.americas.sgi.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.4cvs29 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered "Eric Sandeen" <sandeen@sgi.com>, spoke thus:

>  In short, we're using a kmem_cache_zalloc() function in XFS which just
>  does kmem_cache_alloc + memset.
> 
>  We'd like to incorporate this into the kernel proper, and several others
>  chimed in that it would be useful, so here's the patch.  If it's a no-go
>  with you, we can roll this functionality back under fs/xfs to reduce our
>  changes in the mainline kernel.

Why not use the constructor function interface to kmem_cache_create that is
_already_ in the kernel API?
