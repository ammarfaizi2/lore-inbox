Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVDAHpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVDAHpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVDAHpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:45:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:65203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262658AbVDAHom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:44:42 -0500
Date: Thu, 31 Mar 2005 23:44:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: connector.h
Message-Id: <20050331234421.0bf0f8ea.akpm@osdl.org>
In-Reply-To: <1112339394.9334.70.camel@uganda>
References: <20050331173101.769f5c67.akpm@osdl.org>
	<1112339394.9334.70.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Thu, 2005-03-31 at 17:31 -0800, Andrew Morton wrote:
> > > 
> > > struct cb_id
> > > {
> > > 	__u32			idx;
> > > 	__u32			val;
> > > };
> > 
> > It is vital that all data structures be skilfully commented - they are the
> > key to understanding the code.  Why the struct exists, which actor passes
> > it to which other actor(s), whether the data structure is communicated with
> > userspace, what other data structures it is aggregated with or linked to,
> > locking rules, etc.
> 
> It is described in Documentation/connector/connector.txt.
> Should it also be placed here?

I think it's better to document these things in the code.  Those structs
which are communicated to userspace should be described in connector.txt
because they are part of the API.  But a lot of the structs you have there
are purely knerel-internal.

> > > struct cn_msg
> > > {
> > 
> > Please do
> >
> > 	struct cn_msg {
> 
> Neither structure declaration should have opening brace on the new
> string?

I don't understand your question.

We lay out struct definitions thusly:

struct foo {
	int a;
	int b;
};


