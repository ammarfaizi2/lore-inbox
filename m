Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262271AbRETXvN>; Sun, 20 May 2001 19:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262281AbRETXvD>; Sun, 20 May 2001 19:51:03 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:3852 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262271AbRETXut>;
	Sun, 20 May 2001 19:50:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Patch for sbus makefile bug 
In-Reply-To: Your message of "Sun, 20 May 2001 11:47:38 -0400."
             <20010520114738.A3666@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 09:50:42 +1000
Message-ID: <7440.990402642@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001 11:47:38 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Somebody failed to track a module name change.
>-obj-$(CONFIG_BBC_I2C)			+= bbc.o
>+obj-$(CONFIG_BBC_I2C)			+= bbc_i2c.o

bbc-objs := bbc_i2c.o bbc_envctrl.o

The module is bbc.o, bbc_i2c.o is a sub-object of bbc.o, the selection
is correct (2.4.5-pre4).

