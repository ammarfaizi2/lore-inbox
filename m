Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVIHSzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVIHSzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVIHSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 14:55:16 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:16775 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964922AbVIHSzO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 14:55:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AYqs2MGtrW7K1h0Q3qnrRxeFZzGBXguedp3N2KDF0yRmNzH3GMV4dzDm5fO76s9PSPPlLBhG/qOw3H24zgqlDH81kRY9BpD8lgbr0HC90/K7ULdgMilgXa7sQ1pPJfy4ceAjpYmXuXDf2XhiHB4UF3Hh6F3zWzQWl7+hiOsYEQs=
Message-ID: <9a874849050908115547d9967c@mail.gmail.com>
Date: Thu, 8 Sep 2005 20:55:09 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: ress.weber@gmail.com
Subject: Re: How to plan a kernel update ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9c23279705090810123132447d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c23279705090810123132447d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Weber Ress <ress.weber@gmail.com> wrote:
> Hi,
> 
> I'm responsible to planning a kernel upgrade in many servers, from 2.4
> version to 2.6.13 (last stable version), using Debian 3.1r0a
> 
> My team has good technical skills, but they need to be led. I would
> like know, what's the best pratices and recommendations that a project
> manager need think BEFORE an kernel upgrade.
> 
> A technical guy have a particular vision about this upgrade, but I
> will be very been thankful if I receive from this community another
> vision.. a vision centered in the project process (planning,
> executing, controlling) to make this activity successfully.
> 

Ok, I'm no project manager, I guess I'd be clasified as one of the
"technical guys", but I do upgrade a lot of kernels, so I'll tell you
a little about what I do and what I'd recommend. Then you can do with
that info what you like :)

The very first thing you want to do is to ensure that all core
utilities/tools are up-to-date to versions that will work with your
new kernel.
If you download a copy of the 2.6.13 kernel source, extract it, and
look in the file Documentation/Changes you'll see a list of tools and
utils along with the minimum required version for them to work
properly with that kernel. Ensure those tools are OK.

Once you are sure the core utils are up-to-date you need to go check
whatever other important programs you have on the machine(s) and check
that those are also able to run OK with the new kernel.

Once you are satisfied that everything is up to a level that'll work
with the new kernel you can go build the new 2.6.13 kernel and drop it
in place. You don't need to remove your existing kernel first, you can
just install the 2.6.13 kernel side by side with the old one and test
boot it, then if it doesn't work right you can always reboot back to
the old one.


Most likely you can find documentation for your distribution stating
what version of it is "2.6 ready" - I use Slackware for example, and
Slackware 10.1 is completely 2.6 kernel ready, so on a Slackware 10.1
box there's no hassle at all, I just drop in a 2.6 kernel in place of
the 2.4 one it installs by default and everything is good - all tools
are already ready to cope.



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
