Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUGLUgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUGLUgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUGLUev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:34:51 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:21485 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262730AbUGLUc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:32:56 -0400
Message-ID: <40F2F56C.7010000@zytor.com>
Date: Mon, 12 Jul 2004 13:32:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
References: <20040710184357.GA5014@taniwha.stupidest.org> <E1BjPL3-00076U-00@calista.eckenfels.6bone.ka-ip.net> <20040711215446.GA21443@hh.idb.hist.no> <ccujbr$unl$1@terminus.zytor.com> <20040712195956.GA14105@taniwha.stupidest.org>
In-Reply-To: <20040712195956.GA14105@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Mon, Jul 12, 2004 at 05:56:11PM +0000, H. Peter Anvin wrote:
> 
> 
>>No it won't, since if you're using file descriptors there *is* no C
>>library buffer.  fclose() will, though, and then call close().
> 
> 
> Data sits in the page-cache though, and if you loose power before
> that's flushed you will loose data.  This is why fsync is needed to be
> sure.
> 

Correct.

	-hpa
