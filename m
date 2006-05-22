Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWEVFqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWEVFqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWEVFqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:46:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25055 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932120AbWEVFqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:46:19 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: edac driver names in sysfs. 
In-reply-to: Your message of "Sun, 21 May 2006 22:29:12 -0400."
             <20060522022912.GS8250@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 May 2006 15:44:26 +1000
Message-ID: <9885.1148276666@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (on Sun, 21 May 2006 22:29:12 -0400) wrote:
>EDAC does something funky that no other afaik seems to do.
>
>#define edac_xstr(s) edac_str(s)
>#define edac_str(s) #s
>#define EDAC_MOD_STR edac_xstr(KBUILD_BASENAME)
>
>And then..
>
>	.name = EDAC_MOD_STR,

EDAC is reinventing the wheel.  We have the standard

#include <linux/stringify.h>

	.name = __stringify(KBUILD_BASENAME).

