Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277652AbRJOQLd>; Mon, 15 Oct 2001 12:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277656AbRJOQLX>; Mon, 15 Oct 2001 12:11:23 -0400
Received: from [172.16.44.254] ([172.16.44.254]:17420 "EHLO
	int-mx1.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277652AbRJOQLF>; Mon, 15 Oct 2001 12:11:05 -0400
Date: Mon, 15 Oct 2001 11:12:19 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: ptb@it.uc3m.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: share buffer between user and kernel?
Message-Id: <20011015111219.4cd14672.reynolds@redhat.com>
In-Reply-To: <200110090703.f9973Z601609@oboe.it.uc3m.es>
In-Reply-To: <200110090703.f9973Z601609@oboe.it.uc3m.es>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.3cvs6 (GTK+ 1.2.9; )
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was a dark and stormy night.  Suddenly "Peter T. Breuer" <ptb@it.uc3m.es> spoke:

> What is the currently approved method of sharing a buffer between
> user space and kernel space, so that I can avoid one or two
> copy_to/from_user?

Two basic choices here:

1) Allocate the buffer in kernel space and use the mmap() method to give the
user-space program access to it; and

2) Allocate the buffer in you user application program and use the KIOBUF method
to give the kernel and/or hardware access to your buffer.  Look in
<linux/iobuf.h> for kernel-level inspiration.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto:	<reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.236.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923
