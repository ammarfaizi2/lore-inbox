Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVKGHBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVKGHBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKGHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:01:04 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:49059 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964789AbVKGHBC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:01:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HPYxpIxCFluf1suZNGOaMYzlqmJtt+XnMfunG/3eew9EkaOt/cDjhCaj6F2sY4GDBQwrSDQd5rovPTkdPK5ijjjMZZGYz2vJOKqfjOTWth2BKHiDz8xYlZzUwyX2JhX8+ME5kBWdQMcoCGiBz97Lo7GxcX2LWkectkWq6OlWBgA=
Message-ID: <a44ae5cd0511062301h7ce185bfk10ac2d92cd20e433@mail.gmail.com>
Date: Mon, 7 Nov 2005 02:01:01 -0500
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1 -- undefined reference to `edac_mc_handle_ce'
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried building:

CONFIG_EDAC=y
# CONFIG_EDAC_MM_EDAC is not set
CCONFIG_EDAC_AMD76X=y
CONFIG_EDAC_POLL=y

drivers/built-in.o: In function `amd76x_process_error_info':
: undefined reference to `edac_mc_handle_ce'
drivers/built-in.o: In function `amd76x_process_error_info':
: undefined reference to `edac_mc_handle_ue'
drivers/built-in.o: In function `amd76x_probe1':
: undefined reference to `edac_mc_alloc'
drivers/built-in.o: In function `amd76x_probe1':
: undefined reference to `edac_mc_add_mc'
drivers/built-in.o: In function `amd76x_remove_one':
: undefined reference to `edac_mc_find_mci_by_pdev'
drivers/built-in.o: In function `amd76x_remove_one':
: undefined reference to `edac_mc_del_mc'
make: *** [.tmp_vmlinux1] Error 1
