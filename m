Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTDOFTL (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTDOFTK (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:19:10 -0400
Received: from terminus.zytor.com ([63.209.29.3]:35821 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S264273AbTDOFTK (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:19:10 -0400
Message-ID: <3E9B990C.5000503@zytor.com>
Date: Mon, 14 Apr 2003 22:30:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com> <004301c302bd$ed548680$fe64a8c0@webserver> <b7fbhg$sq4$1@cesium.transmeta.com> <20030415045637.GB25139@mail.jlokier.co.uk>
In-Reply-To: <20030415045637.GB25139@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> It's a quality of implementation issue if data can remain dirty in RAM
> forever without ever being flushed.
> 
> Can this really happen with normal open/mmap/munmap/close usage, or
> does it only occur with long-lived processes like innd which mmap a
> file, dirty the pages but never munmap them?
> 
> If the former case does happen, I'd say we're failing on quality of
> implementation.  If it's only the latter case, though, fair enough: the
> application writer will have to use msync().
> 

The latter, I'm pretty sure.  After all, that's what pgflush/bdflush is 
all about.

