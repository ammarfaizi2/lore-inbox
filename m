Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWGHScR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWGHScR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWGHScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:32:17 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:26073 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964953AbWGHScQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:32:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPTzf40Dp+JOMSA5XJheewaj/u5GeyvyJcHHnkdIkuKkzbbtdPw1tAAEaXE9c0yukPNJOHX0qoyBEKyOCyCYbsE/ho6sNN4AAZelldu4nsCiwty0H4yysXO1zvZr44Yezo8+bDJoWmQvacRDCGCwX5qjLTpQNcCPXjAY6Ql83So=
Message-ID: <a4e6962a0607081132u4558473cgf89b8b25fcea317d@mail.gmail.com>
Date: Sat, 8 Jul 2006 13:32:15 -0500
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: [RFC] VFS: FS CoW using redirection
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200607082041.54489.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607082041.54489.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/06, Al Boldi <a1426z@gawab.com> wrote:
>
> Copy on Write is a neat way to quickly achieve a semi-clustered system, by
> mounting any shared FS read-only and redirecting writes to some perClient
> FS.
>
> Would this redirection be easy to implement into the VFS?
>

There are a variety of solutions that have been proposed or are
available to do this sort of thing.  You may want to start by looking
at unionfs and mapfs.  There are also folks looking at doing this from
the block layer (look at the dm-userspace + cowd as well as evms and
lvm snapshots).

            -eric
