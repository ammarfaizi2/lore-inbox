Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSCCPfz>; Sun, 3 Mar 2002 10:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSCCPfp>; Sun, 3 Mar 2002 10:35:45 -0500
Received: from president.eu.org ([194.45.71.67]:34566 "EHLO president.eu.org")
	by vger.kernel.org with ESMTP id <S286825AbSCCPfe>;
	Sun, 3 Mar 2002 10:35:34 -0500
Date: Sun, 3 Mar 2002 13:38:02 +0100
From: Hans Freitag <macrotron@president.eu.org>
To: linux-kernel@vger.kernel.org
Subject: sscanf()/vsscanf() isn't able to handle Hex digits
Message-ID: <20020303133802.A5430@darkzone.president.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-PGP-Ident: 204D1441
X-PGP-Keyserver: wwwkeys.eu.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using kernel 2.4.18-pre9.

I want to parse a mac adress within a kernel module. I want to
use int sscanf(const char *buf, const char *fmt, ...) .

This function is located in /usr/src/linux/lib/vsprintf.c .

Mac addresses like 6f:6f:7f:9a:10:11 are parsed correctly,
fd:23:22:fd:df:77 fails.

The reason is located in vsprintf.c line 640:

if (!*str || !isdigit(*str))
	break;

I think isxdigit(*str) might be better here.

bye
-- 
May the source be with you!
