Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVANHGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVANHGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 02:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVANHGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 02:06:12 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:49544 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261307AbVANHGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 02:06:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rn2E9S8LYBs6s0NDO6vMMz9AmKnG4ZQAAtSW4nV7kACZJXKIpuwE87Z+lR3/oIu2HF1GRU1SLswwbgbYRYtjiGMcAL6Z1uAbOuxpru0aV/Jcm+nanEGqJRAoIbF6VkUGdNJAjUvQQixG2VbxokLGyLk2/DpQQjsylYtJsP6/Yq4=
Message-ID: <a36005b505011323061bd2e4a9@mail.gmail.com>
Date: Thu, 13 Jan 2005 23:06:05 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
In-Reply-To: <20050113225244.GH14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050113134620.GA14127@boetes.org>
	 <a36005b5050113131179d932eb@mail.gmail.com>
	 <20050113225244.GH14127@boetes.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 23:52:22 +0100, Han Boetes <han@mijncomputer.nl> wrote:
> To avoid that I would like to ask you if you can show me some
> example-code, something I which can compile and run and see for
> myself, for the following situations:

The analysis of the patch does not stem from trying programs and
seeing them failing.  The gcc maintainers looked at it with
understanding of the compiler and the way the patch interacts with the
existing code.  It might be possible for them to come up with a
program which is miscompiled.  More importantly, though, it'll most
probably be possible to come up with code which should be instrumented
but isn't.  You must agree that this is a terrible thing to happen. 
The patch gives a wrong sense of security.

Finally, the gcc patch is not going to work as is on architectures
like IA-64 which do not have the kind of adressing modes which are
needed for the code to work.

To fully understand the problem, you need to understand compiler
design, and especially RTL.  The latter by itself is another problem:
getting the code work in gcc 4 is at least challenging due the SSA.

Anyway, if you want more information you'll need to ask the gcc people.
