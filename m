Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbUK3S0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbUK3S0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUK3S0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:26:24 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:36710 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262202AbUK3S0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:26:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o7jVl4ecXyB7S8HQD65xmblmgCfbq/qI6uUnIkImVjaO2PnKzV6AEu5ZS+cZpbIfGwxo2a/CuXlB6BooHvsV5omce2nvfuApJpUuEiDx0kzc9Mj8hn/64/d3dbtZe+4bnqZouVRtHqL86r5ebEvHmL6mFrte9HHLQIU35249f6w=
Message-ID: <2c59f00304113010262063d219@mail.gmail.com>
Date: Tue, 30 Nov 2004 23:56:07 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: file as a directory
In-Reply-To: <Pine.LNX.4.53.0411301844100.16712@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
	 <1101832103.2885.4.camel@zathras.emsl.pnl.gov>
	 <Pine.LNX.4.53.0411301740430.1622@yvahk01.tjqt.qr>
	 <04113011354200.08643@tabby>
	 <Pine.LNX.4.53.0411301844100.16712@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot imagine viewing the entire filesystem as a single huge XML file. 

My suggestion is to add a framework, an infrastructure, in the VFS
wherein a simple plugin can be written to poke into the file as if it
were a directory. So with that framework in place, I can write a
plugin for archive support (treating the .tar files as directories),
Peter could write a plugin for poking into /etc/passwd (treating it as
a directory), and Jon Doe could write a plugin for sendmail.cf

like:
--
struct file_operations ops = {
   .read            = tar_readdir,
   .readdir        = tar_readdir,
   ......
};

register_file_type("tar", &ops);
--

How good would this be? 

AG
--
May the source be with you.
