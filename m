Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSK0KsF>; Wed, 27 Nov 2002 05:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbSK0KsF>; Wed, 27 Nov 2002 05:48:05 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5394 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262130AbSK0KsF>;
	Wed, 27 Nov 2002 05:48:05 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe 
In-reply-to: Your message of "Tue, 26 Nov 2002 19:45:50 -0000."
             <200211261945.gAQJjoRe000267@darkstar.example.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Nov 2002 21:55:11 +1100
Message-ID: <11412.1038394511@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002 19:45:50 +0000 (GMT), 
John Bradford <john@grabjohn.com> wrote:
>Why don't we introduce a make allworkingmodules config, which compiles
>everything as modules, except for the things that are broken as
>modules, (for example IDE in the current 2.5.x tree would be compiled
>in).

cat > .force_default <<EOF
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
EOF
make allmodconfig 

That used to work, until 2.5.48.  Being able to force selected options
and have the rest of the options default to all Y or all M was
extremely useful.  What a pity that Kconfig removed this facility.

