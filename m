Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUEWRL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUEWRL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUEWRL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:11:29 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:25083 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S262499AbUEWRL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:11:28 -0400
Message-ID: <40B0DB49.3090308@quark.didntduck.org>
Date: Sun, 23 May 2004 13:11:37 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Arjan van de Ven <arjanv@redhat.com>, Christoph Hellwig <hch@lst.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
References: <20040522234059.GA3735@infradead.org> <1085296400.2781.2.camel@laptop.fenrus.com> <20040523084415.GB16071@alpha.home.local>
In-Reply-To: <20040523084415.GB16071@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Arjan,
> 
> On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
> 
>>on first look it seems to be missing a bunch of get_user() calls and
>>does direct access instead....
> 
> 
> It was intentional for speed purpose. The areas are checked once with
> verify_area() when we need to access memory, then data is copied directly
> from/to memory. I don't think there's any risk, but I can be wrong.

Which will break with 4G/4G.  You must use at least __get_user().

--
				Brian Gerst
