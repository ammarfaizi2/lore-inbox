Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVGPR1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVGPR1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGPR1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:27:06 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:34769 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261741AbVGPR1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:27:04 -0400
Message-ID: <42D94361.7050609@ens-lyon.org>
Date: Sat, 16 Jul 2005 19:26:57 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: k8 s <uint32@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling Kernel Modules with debugging information enabled
References: <699a19ea05071610115fcc827f@mail.gmail.com>
In-Reply-To: <699a19ea05071610115fcc827f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16.07.2005 19:11, k8 s a écrit :
> To be more clear, say I have selected CONFIG_XFRM=y in .config file
> I want to make a change such that net/xfrm/Makefile has an entry 
> CFLAGS += -g so that it generates debugging information for all the
> modules in that directory

Look at Documentation/kbuild/makefiles.txt:

You can add some CFLAGS for a single object file with:
CFLAGS_foo.o += -g

For all objects defined in a Makefile:
EXTRA_CFLAGS = +g

Brice
