Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317763AbSGaFQz>; Wed, 31 Jul 2002 01:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSGaFQz>; Wed, 31 Jul 2002 01:16:55 -0400
Received: from cairu.terra.com.br ([200.176.3.19]:55458 "EHLO
	cairu.terra.com.br") by vger.kernel.org with ESMTP
	id <S317763AbSGaFQy>; Wed, 31 Jul 2002 01:16:54 -0400
Date: Wed, 31 Jul 2002 02:20:15 -0300
From: Christian Reis <kiko@async.com.br>
To: linux-kernel@vger.kernel.org
Subject: odd tmpfs behaviour
Message-ID: <20020731022015.B799@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick question, to see if anyone has run into this problem
before: I'm using tmpfs mounted with default options on to /tmp. 

I hadn't noticed this before, but my config.status scripts (for any sw
package; stunnel-3.22 is my current example here) now loop endlessly
because, apparently, the files in /tmp/cs*/ don't change when written to
in a very short while loop. 

As a short test, I compared using /tmp which is tmpfs to /var/tmp, which
is reiserfs, and the difference shows: in /tmp, I get an infinite loop;
in /var/tmp, 4 iterations. Anybody seen this?

I can attach a strace file if it will help somebody; let me know.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
