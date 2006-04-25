Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWDYOET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDYOET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWDYOET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:04:19 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:8329 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932224AbWDYOES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:04:18 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: schwidefsky@de.ibm.com
Cc: Michael Holzheu <HOLZHEU@de.ibm.com>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <1145637630.6884.7.camel@localhost>
References: <OF5500FC25.13788C4B-ON42257157.004C98F0-42257157.004DB206@de.ibm.com>
	 <1145633898.13191.9.camel@localhost>  <1145637630.6884.7.camel@localhost>
Date: Tue, 25 Apr 2006 17:04:14 +0300
Message-Id: <1145973854.11508.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, 2006-04-21 at 18:38 +0300, Pekka Enberg wrote:
> > The update-on-write to special file thing seems bit strange to me. What
> > if two processes ask for it at the same time?

On Fri, 2006-04-21 at 18:40 +0200, Martin Schwidefsky wrote:
> Yes, we had that discussion as well. Any sensible suggestion how to do
> it in a more clever way would be greatly appreciated. We haven't found
> something better so far.

The only way I can think of is via s_ops->remount_fs. That's bit safer
anyway, as sb->s_lock protects us from concurrent updates. I am cc'ing
fsdevel to see if they can come up with a better suggestion.

				Pekka

