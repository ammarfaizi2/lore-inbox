Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbSIPW6Y>; Mon, 16 Sep 2002 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbSIPW6Y>; Mon, 16 Sep 2002 18:58:24 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:20978 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263288AbSIPW6Y>; Mon, 16 Sep 2002 18:58:24 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020916.154640.78359545.davem@redhat.com> 
References: <20020916.154640.78359545.davem@redhat.com>  <20020916.125211.82482173.davem@redhat.com> <Pine.LNX.4.44.0209161528140.13850-100000@gp.staff.osogrande.com> <12116.1032216780@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, netdev@oss.sgi.com, pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Sep 2002 00:03:19 +0100
Message-ID: <12293.1032217399@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
> >   Er, surely the same goes for sys_sendfile? Why have a new system
> >   call rather than just swapping the 'in' and 'out' fds?

> There is an assumption that one is a linear stream of output (in this
> case a socket) and the other one is a page cache based file.

That's an implementation detail and it's not clear we should be exposing it 
to the user. It's not entirely insane to contemplate socket->socket or 
file->file sendfile either -- would we invent new system calls for those 
too? File descriptors are file descriptors.

> It would be nice to extend sys_sendfile to work properly in both ways
> in a manner that Linus would accept, want to work on that? 

Yeah -- I'll add it to the TODO list. Scheduled for some time in 2007 :)

More seriously though, I'd hope that whoever implemented what you call 
'sys_receivefile' would solve this issue, as 'sys_receivefile' isn't really 
useful as anything more than a handy nomenclature for describing the 
process in question.

--
dwmw2


