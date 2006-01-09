Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWAIGIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWAIGIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWAIGIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:08:45 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:40358 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751464AbWAIGIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:08:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kP2iYVoU9qPONHr5194xtN6yJjzXvJey9TkFi0c6xp3JDGDDBtZgQPBjkta58jo/CowCJ3KSn582pyObiXuBB8ZqKwWEpQRBTYeoA/4pPutjQpNQf+kd4ROMoBz936XAstIortwkuNM6UHPOoRCkOY400Ee+U6tEPl06SAaH2x8=
Message-ID: <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
Date: Mon, 9 Jan 2006 19:08:44 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: git pull on Linux/ACPI release tree
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       git@vger.kernel.org
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
> This is completely insane.
> Do you have any idea what "sometimes has problems merging" means
> in practice?  It means the tools are really nifty in the trivial
> case but worse than worthless when you need them the most.

Len,

all I meant was that you will sometimes see conflicts. And in that
case, you are far better off cancelling the rebase and doing a merge,
where you will have to resolve the conflicts by hand.

git-rebase is for when the potential merge is clearly trivial. In any
other case, you do want a proper merge. But in any case, it is easy to
do

    git-fetch <upstream> && git-rebase <upstream>

and if it does anything but a very trivial merge, backtrack and do a merge.

In any case, if I have any suspicion that the merge may not be trivial, I do

   git-fetch <upstream> && gitk --since=" 1 month ago" upstream master

before deciding on a course of action. Of course, you can merge all
the time. It's whether people care about a readable/useful history
afterwards.

cheers,


martin
