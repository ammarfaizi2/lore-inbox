Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRIYTqc>; Tue, 25 Sep 2001 15:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIYTqQ>; Tue, 25 Sep 2001 15:46:16 -0400
Received: from [172.16.44.254] ([172.16.44.254]:44050 "EHLO
	int-mx1.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273303AbRIYTpv>; Tue, 25 Sep 2001 15:45:51 -0400
Date: Tue, 25 Sep 2001 14:46:11 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GFP_FAIL?
Message-Id: <20010925144611.01590a08.reynolds@redhat.com>
In-Reply-To: <20010924210951.A165@bug.ucw.cz>
In-Reply-To: <20010924210951.A165@bug.ucw.cz>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.2cvs5 (GTK+ 1.2.9; )
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> was pleased to say:

> Hi!
> 
> I need to alloc as much memory as possible, *but not more*. I do not
> want to OOM-kill anything. How do I do this? Tried GFP_KERNEL, will
> oom-kill. GFP_USER will OOM-kill, too.

Try GFP_ATOMIC; GFP_KERNEL sets the __GFP_WAIT flag and you don't want that.
But, if you're really asking how to know how large the current working set is,
so that you don't grab more than your applications are going to need and
eventually OOM, you'll need to set GFP_HAVE_CRYSTAL_BALL ;-)

-- 

Tommy Reynolds                               |
Red Hat, Inc. (Embedded Development)         | "The quickest way to do anything
307 Wynn Drive NW, Huntsville, AL 35805 USA  |  is right the first time."
mailto:reynolds@redhat.com                   |       - The Lieutenant (Rick
Phone:  +1.256.704.9286                      |         Jason), "Combat!",
Mobile: +1.919.641.2923                      |         1962 TV series
FAX:    +1.256.837.3839                      |
