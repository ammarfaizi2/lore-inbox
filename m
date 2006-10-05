Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWJEOk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWJEOk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWJEOk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:40:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39854 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932076AbWJEOk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:40:56 -0400
Subject: Re: sunifdef instead of unifdef
From: David Woodhouse <dwmw2@infradead.org>
To: Dennis Heuer <dh@triple-media.com>
Cc: linux-kernel@vger.kernel.org, dot@dotat.at
In-Reply-To: <20061005150816.76ca18c2.dh@triple-media.com>
References: <20061005150816.76ca18c2.dh@triple-media.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:40:53 +0100
Message-Id: <1160059253.26064.69.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 15:08 +0200, Dennis Heuer wrote:
> unifdef is not only very old and unmaintained, the binary does not work
> and the source does not compile on a pure x86_64 system. 

It works for me. Describe your problem more coherently.

I wouldn't describe it as 'very old' -- the last commit seems to have
been last March, which isn't _so_ recent but perhaps it just hasn't
_needed_ an update?

Neither would I describe it as unmaintained. Tony was quite quickly
responsive when I asked him if it would be OK to include unifdef in the
kernel source tree.

> There is another tool that worked for me--though it 'closed with
> remarks'--and that was updated recently (several times this year). It
> is called sunifdef, is under an equal (new) BSD license, and is
> proposed to be the successor of unifdef. See the project page:
> 
> http://www.sunifdef.strudl.org/ 

I don't see a huge point in changing, unless it lets us get rid of stuff
like 

	#if defined(__KERNEL__ && ....

when used with -U__KERNEL__.

-- 
dwmw2

