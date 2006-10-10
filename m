Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWJJF0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWJJF0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWJJF0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:26:10 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:57667 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964985AbWJJF0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:26:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dhf1muYxoZ1mnSKKO/JsPCRhIQ9I1+w7w+xIcys8UWoLT0vVSIThH+yt891IkltF7jJeLOhrEyJZFZ0JjcaJyLS5TGxQLF2PddzV44umWeWUl37g48E9wsYvbUVIqfz09UW8wpKxOMW6dPK/DSVgI6E49tylHPzdxyn2Abn1+vo=
Message-ID: <309a667c0610092226q7c92b325qcf262e7df56c27a@mail.gmail.com>
Date: Tue, 10 Oct 2006 10:56:07 +0530
From: "Devesh Sharma" <devesh28@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: Compiling dependent module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061007181936.GA5937@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <309a667c0610070512y47718898i4a664ef6cce7c312@mail.gmail.com>
	 <20061007181936.GA5937@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sam, thanks for replying,

I have another doubt in the same,
generally when we compile any external kernel module which uses some
kernel symbol, there we don't see any such warnings even though we are
compiling our module separately?  So compiling a dependent module
separately is similar to compiling a external kernel module.
Why such warninigs are being observed here in dependent module while compiling?

On 10/7/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sat, Oct 07, 2006 at 05:42:47PM +0530, Devesh Sharma wrote:
> > Hello all,
> >
> > I have a situation where, I have one parent module in ../hello/
> > directory which exports one symbol (g_my_export). I have a dependent
> > module in ../hello1/ directory. Both have it's own makefiles.
> > Compiling of parent module (hello.ko) is fine, but during compilation
> > of dependent module (hello1.ko) I see a warning that g_my_export is
> > undefined.
> >
> > On the other hand when I do depmod -a and modprobe, dependent module
> > inserts successfully in kernel.
> >
> > I want to remove compile time warning. What should I do?
>
> Compile both module in same go.
> See Documentation/kbuild/modules.txt for a description.
>
> In short create a kbuild file that points to both modules
> so kbuild knows about both modules when it builds them.
>
>         Sam
>
