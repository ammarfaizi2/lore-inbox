Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVAQW7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVAQW7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVAQW5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:57:30 -0500
Received: from terminus.zytor.com ([209.128.68.124]:24798 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262979AbVAQWs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:48:27 -0500
Message-ID: <41EC4090.60709@zytor.com>
Date: Mon, 17 Jan 2005 14:47:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com> <20050117221331.GC17132@mars.ravnborg.org>
In-Reply-To: <20050117221331.GC17132@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Jan 17, 2005 at 02:03:41PM -0800, H. Peter Anvin wrote:
> 
>>I don't mind the current default, but saying I shouldn't be able to 
>>override it is asinine.
> 
> No-one asked for it until now.

That's of course perfectly fair, and I'm not flaming you for saying that 
noone had asked for it.  Saying that it *shouldn't* be done is another 
matter, that's all.

> Any preferred syntax to disable this dependency check?

How about "make CCDEP=0"?

> 
>>It also means "make install" is largely unusable.
> 
> Maybe we should not let install be dependent on vmlinux then?

Maybe not.  I don't think "modules_install" have any explicit 
dependencies, it's up to the user to make sure things are already built, 
so we might as well do the same thing with "make install".

	-hpa

