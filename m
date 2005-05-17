Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVEQIdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVEQIdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 04:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVEQIdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 04:33:38 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:35854 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261326AbVEQIdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 04:33:31 -0400
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <200505171057.10540.vda@ilport.com.ua>
References: <1116263665.2434.69.camel@CoolQ>
	 <200505161758.j4GHw4EW009866@turing-police.cc.vt.edu>
	 <1116348446.2428.38.camel@CoolQ>  <200505171057.10540.vda@ilport.com.ua>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116358863.2428.123.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 15:41:03 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 03:57, Denis Vlasenko wrote:
> On Tuesday 17 May 2005 19:47, fs wrote:
> I think you want too much from fs developers. Use this:
> 
> 	if(error)
> 		if(errno==...) {...}
> 		else if(errno==...) {...}
> 		else {...}  <------------ handle any other errors
> 
> and be happy.
For users, the OS is a black box, it provides services of FS.
The OS should hide differences of each FS, so usermode app can
run happily on every FS. For the same reason, OS should return
the same error, no matter what FS it comes from. Users only care
about the interface, not the implementation. So, OS should
_AT LEAST_ make the interface clear(here means the syscall should
return a definite error)

> --
> vda
> 

regards,
----
Qu Fuping


