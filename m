Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSE2Q4m>; Wed, 29 May 2002 12:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSE2Q4l>; Wed, 29 May 2002 12:56:41 -0400
Received: from web20514.mail.yahoo.com ([216.136.173.246]:18853 "HELO
	web20514.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313698AbSE2Q4j>; Wed, 29 May 2002 12:56:39 -0400
Message-ID: <20020529165638.81454.qmail@web20514.mail.yahoo.com>
Date: Wed, 29 May 2002 18:56:38 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux 2.4.19-pre9 - compilation test
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So here goes the last -pre.

Hi Marcelo !

FYI, I tried to compile everything with gcc 2.95.3.
I applied Juan's patch to sdla before. It mostly 
consisted in modules, complemented by a
not-too-fat kernel. I got the following results :
  - 928 modules that compile correctly
  - pcilynx still doesn't compile ("num_of_cards"
    and "cards" definitions have been removed)
  - sm_afsk{1200,2400,4800} don't compile

Among the 928 modules, some don't resolve their
dependencies :
   - comx still references proc_get_inode(). I had an
     old fix fot that, but IIRC the whole driver
needed
     a global lifting anyway
   - pcihpacpi references acpi_walk_namespaces
     which it cannot find if
     CONFIG_HOTPLUG_PCI_ACPI=m.   OK if =y.

Didn't try to boot on it yet.

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
