Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTDNUP0 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTDNUP0 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:15:26 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:29168 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S263932AbTDNUPY (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:15:24 -0400
Date: Mon, 14 Apr 2003 22:27:41 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
Message-ID: <20030414202741.GA26414@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com> <004301c302bd$ed548680$fe64a8c0@webserver> <Pine.LNX.4.53.0304141559140.28851@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0304141559140.28851@chaos>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 04:13:52PM -0400, Richard B. Johnson wrote:
> 
> Memory mapped files are supposed to be accessed through memory!
> Any program that needs to know what's on the physical disk is
> broken. If you need to write to files and know when they are
> written to the physical media, you use a journaled file-system.

It is not that simple.
Shared mmaped files are _never_ flushed, at least in 2.4.x. So,
without an explicit msync() a process (innd comes to mind) may loose
years of updates upon a system crash or power outage.

I have learned to live with it but I still find this a bit awkward.

-- 
Frank
