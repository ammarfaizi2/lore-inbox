Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314336AbSDRMqq>; Thu, 18 Apr 2002 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314337AbSDRMqp>; Thu, 18 Apr 2002 08:46:45 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39433 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S314336AbSDRMqo>; Thu, 18 Apr 2002 08:46:44 -0400
Message-ID: <3CBEC025.141CAA76@aitel.hist.no>
Date: Thu, 18 Apr 2002 14:46:29 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Tony Clarke <sam@palamon.ie>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM Related question
In-Reply-To: <3CBE8FBB.8080108@palamon.ie>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Clarke wrote:
> 
> I have noticed with my current kernel that after the system is idle for
> a while, say 10 hours or
> so, that everything seems to be swapped out to disk. So when I come in
> the next morning
> it starts swapping everything like crazy in from disk. Is this a known
> characteristic of the
> VM. I seem to remember this with all 2.4 kernels tried to date.
> 
> Whats the point of swapping out to disk in circumstances like this?
> 
> Currently I am using 2.4.18-rc2-ac2, with apps like mozilla, dozen
> xterms, xemacs, staroffice etc.

The kernel makes no decision to swap just because you left the
machine.  But your distro probably runs "updatedb" at night.
Updatedb reads all the directories in all your filesystems, so
it tends to use a lot of cache.  This activity pushes
lots of other stuff into swap.

You may of course change your crontab to runn updatedb less
often, or configure updatedb to skip directory
trees where you expect little change. (/usr perhaps...)

Helge Hafting
