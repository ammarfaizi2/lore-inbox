Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264383AbRFSQND>; Tue, 19 Jun 2001 12:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbRFSQMx>; Tue, 19 Jun 2001 12:12:53 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:2826 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S264383AbRFSQMq>; Tue, 19 Jun 2001 12:12:46 -0400
Date: Tue, 19 Jun 2001 11:12:37 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0106181940400.18769-100000@weyl.math.psu.edu>
In-Reply-To: <PD1Rx.A.X-F.-YnL7@dinero.interactivesi.com>
Subject: Re: What happened to lookup_dentry?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <g_XL8.A.V8G.4n3L7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Alexander Viro <viro@math.psu.edu> on Mon, 18 Jun 2001
19:45:11 -0400 (EDT)


> It depends on what kind of use 2.2 code had for it. There are several
> situations in which it used to be called and proper replacements depend
> on the context. Details, please... (alternatively, send an URL of patch
> and I'll see what to do with the thing)

Well, I didn't write the driver that I'm trying to port, so it's a little
difficult.  The code in question is:

struct dentry *	de = lookup_dentry(zfcdb[i].fullname, NULL, LOOKUP_FOLLOW);
if (IS_ERR(de))
	continue;
if (de != zfcdb[i].dentry) 
{
	print("zfc: dentry changed for %s\n", zfcdb[i].fullname);
	zfc_file_init(&zfcdb[i], de);
}

So it appears it's just checking to see if the dentry for a particular file has
changed.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

