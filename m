Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313639AbSEARGS>; Wed, 1 May 2002 13:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313660AbSEARGR>; Wed, 1 May 2002 13:06:17 -0400
Received: from gherkin.frus.com ([192.158.254.49]:1152 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S313639AbSEARGQ>;
	Wed, 1 May 2002 13:06:16 -0400
Message-Id: <m172xYI-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
In-Reply-To: <5.1.0.14.2.20020501130602.00cabaf0@192.168.2.131>
 "from system_lists@nullzone.org at May 1, 2002 01:14:25 pm"
To: system_lists@nullzone.org
Date: Wed, 1 May 2002 12:06:02 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system_lists@nullzone.org wrote:
> server01:/var/log# ls -laF
> <snip>
> drwxr-s---    2 mail     adm           104 Mar 12 23:29 exim/
> <snip>
> 
> server01:/var/log# ls -laF exim
> ls: exim/.: Permission denied
> ls: exim/..: Permission denied
> ls: exim/rejectlog: Permission denied
> ls: exim/mainlog: Permission denied
> total 0
> server01:/var/log# whoami
> root
> server01:/var/log# id
> uid=0(root) gid=0(root) groups=0(root)
> server01:/var/log#

Confirmed on a 2.5.11 system as well.  Talk about your basic heart
attack!  I'd just installed Postfix and found that I couldn't access
any of the directories under /var/spool/postfix.  Fortunately (?),
I've got older kernels to fall back on, and that's one of the hazards
of running on the bleeding edge I reckon.

Oh yeah...  ext2 filesystem.  I think this bug is at least mostly
independent of the filesystem type.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
