Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbTFLC6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbTFLC6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:58:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4262 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264691AbTFLC6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:58:38 -0400
Date: Wed, 11 Jun 2003 22:11:12 -0500
From: Boris <boris@boris.ca>
Subject: 2.4.21pre8/cs46xx.c and gcc 3.3 problems
To: linux-kernel@vger.kernel.org
Message-id: <004001c33090$478c8080$43444218@raiden>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that gcc 3.3 doesn't like the cs46xx driver and causes and error.
The quick fix was to change the following lines

line 948-952
struct InitStruct
{
    u32 long off;
    u32 long val;
}

to

struct InitStruct
{
    u32 off;
    u32 val;
}


I am not sure this is the exact fix to use but it works. Anyway to getting
this fixed?

