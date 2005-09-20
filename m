Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVITWr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVITWr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVITWr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:47:59 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:23197 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750709AbVITWr7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:47:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mez5HcN/Ji0o9fCB/9yDT7AdOUFkMJInwkxzbk37Lqm9h+psq7tKgddMt3/04rmg/+ryiHk7y/sMroFsQC4kBPxk4wcJ76EgnqN5seJSUriTdD8EK9b/h8RAHF/VzB5hyXYYEn2P8xuBcYNKIfjwrVBKNhj4t3QJ1TJjJ7MBfVc=
Message-ID: <9a87484905092015471c2dc329@mail.gmail.com>
Date: Wed, 21 Sep 2005 00:47:56 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Hot-patching
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43308815.1000200@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43308815.1000200@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, John Richard Moser <nigelenki@comcast.net> wrote:
[snip]
> Besides getting rid of a pet peeve of mine (more rebooting than
> absolutely necessary) and giving a way to continuously increase the size
> of the running kernel with each bugfix, this has implications on servers
> that don't want to reboot for whatever reason.  For enterprise
> applications, it would be possible to fix a kernel bug or security hole
> that hasn't been triggered by loading a module with the bugfixes,
> effectively hot-patching the kernel.
> 
[snip]

If you have uptime demands like that I think a much better approach
would be to make sure the box is heavily firewalled so importance of
the security of the host itself drops. If there's no way to get to a
box in a way that enables you to actually exploit a security hole,
then it doesn't matter much that the hole is there at all.

Another option would be a clustered setup where you normally run the
app(s) on nodeA, nodeB ... nodeN, then when you need to upgrade you
move all running applications off of nodeA and upgrade it, move
everything off of nodeB and then upgrade that, repeat for nr of nodes,
finally redistribute the load properly again.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
