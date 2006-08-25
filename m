Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWHYVYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWHYVYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWHYVYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:24:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:46786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751498AbWHYVYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:24:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jpPe4EmIAyJ/KF3haoy6qrlUuMsTEgEQQV209RlQZ/MlSdzIbrkEX0nWFp6pZ+NR4ukGdGHtmBplui0FjN8qxNRI458yl84KiocWcbW/BtqS/XlKxJNUJk8uLZ09H/DN2FhcOZKOby3RrmBcQ2jv509ZVL5Rmeb701qvXPDJnDo=
Date: Sat, 26 Aug 2006 01:24:41 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060825212441.GC2246@martell.zuzino.mipt.ru>
References: <20060825203047.GH13641@csclub.uwaterloo.ca> <1156540817.3007.270.camel@localhost.localdomain> <20060825210305.GL13639@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825210305.GL13639@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 05:03:05PM -0400, Lennart Sorensen wrote:
> > Is the buffer 32bit aligned ?
>
> I honestly don't know.

But you can check. Insert something like this in right place:

	printk("%p\n", buffer);

> I am just trying to figure out why the jsm
> driver isn't working on this system while it works on other types of
> hardware, and so far it seems to come down to the __memcpy assembly not
> being happy on the SC1200 doing more than one byte at a time.  it is
> very consistently making the same mistake all the time.

