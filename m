Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424108AbWKPOp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424108AbWKPOp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424109AbWKPOp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:45:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41196 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1424108AbWKPOp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:45:28 -0500
Date: Thu, 16 Nov 2006 08:47:43 -0600
From: "Bill O'Donnell" <billodo@sgi.com>
To: Chris Friedhoff <chris@friedhoff.org>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061116144743.GA21497@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org> <20061113215706.GA9658@sgi.com> <20061114052531.GA20915@sergelap.austin.ibm.com> <20061114135546.GA9953@sgi.com> <20061114152307.GA7534@sergelap.austin.ibm.com> <455B0357.2050400@ak.jp.nec.com> <20061115170633.GA21345@sgi.com> <20061115224923.539fe60a.chris@friedhoff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115224923.539fe60a.chris@friedhoff.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 10:49:23PM +0100, Chris Friedhoff wrote:
| On Wed, 15 Nov 2006 11:06:34 -0600
| "Bill O'Donnell" <billodo@sgi.com> wrote:
| 
| - snip - 
| > | Probably, Bill didn't update libcap.so.
| > No, I didn't...
| > certify:~/libcap-1.10/progs # ls -altr /lib/libcap*
| > -rwxr-xr-x 1 root root 22672 2006-06-16 09:56 /lib/libcap.so.1.92
| > -rw-r--r-- 1 root root 53363 2006-11-13 16:04 /lib/libcap.so.1.10
| > lrwxrwxrwx 1 root root    14 2006-11-13 16:04 /lib/libcap.so.1 ->libcap.so.1.92
| > lrwxrwxrwx 1 root root    11 2006-11-13 16:04 /lib/libcap.so -> libcap.so.1
| > 
| 
| Why is SLES10 using libcap-1.92?
| (googling brought this page:
| http://www.me.kernel.org/pub/linux/libs/security/linux-privs/old/kernel-2.3/)

Good quesion.  My gentoo ia32 machine uses libcap.so.1.10.  Probably a FAQ, 
but is 1.92 actually older than 1.10?

| 
| > | 
| > | But I can't recommend Bill to update libcap immediately.
| > | As Hawk Xu said, it may cause a serious problem on the distro
| > | except Fedora Core 6. :(
| > 
| > What version of libcap is on FC6? 
| > 
| 
| Are there newer libcap versions then libcap-1.10 available?
| (http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/)

| 
| > | 
| > | I have to recommend to use 'fscaps-1.0-kg.i386.rpm' now.
| > | It includes the implementation of interaction between application and xattr.
| > | (Of couse, it's one of the features which should be provided by libcap.)
| > 
| > But that won't work on ia64 will it?
| 
| Kaigai also provides a srpm package to compile.
|  VFS Capability Support -> fscaps version 1.0 [SRPM]
| (http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm)

I'll try that next.

Thanks, 
Bill

