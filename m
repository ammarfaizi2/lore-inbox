Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVIWSk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVIWSk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVIWSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:40:57 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:59045 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751133AbVIWSk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:40:57 -0400
Date: Fri, 23 Sep 2005 20:40:56 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Pablo Fernandez <pablo.ferlop@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: max_fd
Message-ID: <20050923184056.GA2024@janus>
References: <8518592505092305373465a5@mail.gmail.com> <20050923155509.GA4723@in.ibm.com> <20050923170345.GA1555@janus> <20050923172653.GA4573@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923172653.GA4573@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 10:56:53PM +0530, Dipankar Sarma wrote:
> 
> Well, the main reason is that if that code is somehow copied
> by to a lock-free critical section, it could cause problems.
> If you dereference ->fdt multiple times in a lock-free
> section, you could see two different pointers due to
> a concurrent update.

thanks for the explanation. This raises a lot of other questions. What
if max_fds is updated by RCU right after obtaining it...

-- 
Frank
