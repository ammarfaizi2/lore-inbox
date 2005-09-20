Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVITPFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVITPFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVITPFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:05:54 -0400
Received: from [81.2.110.250] ([81.2.110.250]:16286 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964797AbVITPFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:05:54 -0400
Subject: Re: kernel error in system call accept() under kernel 2.6.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43301BC4.9080305@wincor-nixdorf.com>
References: <43301BC4.9080305@wincor-nixdorf.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 16:32:07 +0100
Message-Id: <1127230327.6276.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-20 at 16:25 +0200, Peter Duellings wrote:
> Obviously there are some cases where the accept() system call does
> not set the errno variable if the accept() system call returns
> with a value less than zero:

Not actually possible. The kernel returns a positive value, zero or a
negative value which is the errno code negated. It has no mechanism to
return a negative value and not error.

What does strace show for the failing case ?

