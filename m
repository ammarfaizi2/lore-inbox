Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290740AbSARRMw>; Fri, 18 Jan 2002 12:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290753AbSARRMm>; Fri, 18 Jan 2002 12:12:42 -0500
Received: from fs1.ml.kva.se ([130.237.201.20]:528 "EHLO fs1.ml.kva.se")
	by vger.kernel.org with ESMTP id <S290740AbSARRMd>;
	Fri, 18 Jan 2002 12:12:33 -0500
Date: Fri, 18 Jan 2002 18:13:44 +0100 (CET)
From: Lukas Geyer <geyer@ml.kva.se>
To: <linux-kernel@vger.kernel.org>
Subject: "make htmldocs" chokes on bug in DocBook template
Message-ID: <Pine.LNX.4.33.0201181804520.6868-100000@cauchy.ml.kva.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is close to trivial but anyway deserves to be fixed: "make htmldocs"
fails due to a bug in the template for deviceiobook.tmpl. In the last
chapter the file include/asm-i386/io.h is included which however does not
yet have any DocBook comments (2.4.18pre3). So this basically expands to
nothing and the SGML-parser seems to expect at least an empty paragraph
and complains about the unfinished chapter. Two easy fixes: Either take
this chapter out completely, or replace the include by an empty paragraph
or add some documentation in DocBook format to include/asm-i386/io.h.
(Second one is preferable, I guess.)

Lukas

