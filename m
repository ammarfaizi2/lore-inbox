Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSDARFc>; Mon, 1 Apr 2002 12:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312489AbSDARFW>; Mon, 1 Apr 2002 12:05:22 -0500
Received: from ns.suse.de ([213.95.15.193]:49680 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312480AbSDARFL>;
	Mon, 1 Apr 2002 12:05:11 -0500
To: Beng Asuncion <asmismn1@globalsources.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CLOSE_WAIT bug?
In-Reply-To: <3CA82F7F.312547B8@globalsources.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Apr 2002 19:05:10 +0200
Message-ID: <p734rivtkmx.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beng Asuncion <asmismn1@globalsources.com> writes:

> Dear List,
> 
> We are using 2.4.17 kernel for our Production machines running JRun/Java
> applications + Apache. We are encountering a lot of CLOSE_WAITs like the
> following before our JRun applications die (port 53001 is the Jrun
> port):

You can do a very simple test: if you kill your application completely
(= killing all threads and processes that could keep a socket open) 
and then wait a few minutes the CLOSE_WAITs should go away. If they do
it's not a kernel problem and you just need to fix the application 
to close sockets properly.

-Andi
