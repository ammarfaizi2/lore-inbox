Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVHNVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVHNVeO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVHNVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:34:14 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:56035 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932311AbVHNVeN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:34:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=irchlVg2YqxA2rSAyl1qbwdkWZOjfHZwcYz6vQmx/aF+XS/VgRd1LtNJLB18rDaHelCMdS694NyeByf/4nLuXr8zXDI/Hra1iCjpZGtF/I77irNzekgnNrgB2yEwjy51VLPF7YB0FaOVzRSPSwBLdf92pQmQnlqrabxEQvUtqCE=
Message-ID: <bda6d13a05081414348ac619c@mail.gmail.com>
Date: Sun, 14 Aug 2005 14:34:08 -0700
From: Joshua Hudson <joshudson@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: BSD jail
In-Reply-To: <20050814115651.GA6024@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a050812174768154ea5@mail.gmail.com>
	 <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <bda6d13a0508130933bdbc46a@mail.gmail.com>
	 <20050814115651.GA6024@IBM-BWN8ZTBWA01.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All right, I'll see what I can come up with. This is quite a tall order.
1. A mechanism for creating virtual network interfaces
2. A mechanism for restricting binding to certain network interfaces
3. A mechanism for binding certain network interfaces.
4. The jail code itself

Much of the work is already done in other projects, but it requires grafting.
It seems much simpler to bind the jail's address to an network alias
(such as eth0:1),
and bind the jail to the address of the alias.
