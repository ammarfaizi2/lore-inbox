Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270330AbTGMSZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 14:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270331AbTGMSZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 14:25:20 -0400
Received: from science.horizon.com ([192.35.100.1]:18251 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S270330AbTGMSZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 14:25:19 -0400
Date: 13 Jul 2003 18:40:06 -0000
Message-ID: <20030713184006.9333.qmail@science.horizon.com>
From: linux@horizon.com
To: willy@debian.org
Subject: Re: do_div vs sector_t
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>        if (likely(((n) >> 32) == 0)) {                 \

if (likely((n) <= 0xffffffff)) {

will work with any unsigned type for n.


GCC knows to only look at the high word to make this test.
