Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUJWAIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUJWAIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUJWAHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:07:10 -0400
Received: from mail.joq.us ([67.65.12.105]:2027 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S269259AbUJWAAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:00:00 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1097272140.1442.75.camel@krustophenia.net>
	<20041008145252.M2357@build.pdx.osdl.net>
	<1097273105.1442.78.camel@krustophenia.net>
	<20041008151911.Q2357@build.pdx.osdl.net>
	<20041008152430.R2357@build.pdx.osdl.net>
	<87zn2wbt7c.fsf@sulphur.joq.us>
	<20041008221635.V2357@build.pdx.osdl.net>
	<87is9jc1eb.fsf@sulphur.joq.us>
	<20041009121141.X2357@build.pdx.osdl.net>
	<878yafbpsj.fsf@sulphur.joq.us>
	<20041009155339.Y2357@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: 22 Oct 2004 18:59:50 -0500
In-Reply-To: <20041009155339.Y2357@build.pdx.osdl.net>
Message-ID: <874qkmtibt.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> - less generic variable names
>   - s/any/rt_any/
>   - s/gid/rt_gid/
>   - s/mlock/rt_mlock/

Is there a compelling reason for changing all the parameter names?

I would prefer not to do that.  It is incompatible for our current
user base, and really does not seem like an improvement.  Those names
only appear in the context of `realtime', so the `rt_' is completely
redundant.  For example...

 # modprobe realtime gid=29
 # sysctl -w security/realtime/mlock=0

Also, you forgot to update the documentation.
-- 
  joq
