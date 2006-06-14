Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWFNWee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWFNWee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWFNWee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:34:34 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:52945 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964911AbWFNWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:34:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P+jRYc7JzQRU690eTRzphJoLHO7BawmN0Wp/C5H6d7birvaHMYq/uVHEnmyfHpItFkOsPj0FOE7hAzgHBEYSIJQkRohf1gP54++arl3n7DJOx3LKu2PUlD+0iIS2MOYKcIm1EIKcMpEcEntTfiQ24F/c3of9qX4aSNceUgB4KPA=
Message-ID: <5c49b0ed0606141534o45c75699n490f4accbfee028d@mail.gmail.com>
Date: Wed, 14 Jun 2006 15:34:33 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Marc Perkel" <marc@perkel.com>
Subject: Re: Visionary ideas for SQL file systems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <448F8F18.4030200@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448F8F18.4030200@perkel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/06, Marc Perkel <marc@perkel.com> wrote:
> I'm going to throw this idea out there just to get people thinking.
> There's nothing in reality that is like this except maybe some of the
> ReiserFS ideas, but I want to take the idea farther. the idea is ......

recommend reading hans' future_vision.html paper at namesys.com, as
well as dominic's "FS design with the Be file system" which is a pdf
somewhere online now.  some intense study of ADT's is also recommended

> Why not put an SQL filesystem directly on a block devices where files
> are really blobs within the filesystem and file names and file
> attributes are all indexed data withing the SQL database. The operating
> system will have SQL built in.

after going over the suggested reading above, you'll see why SQL is
less than ideal

> Right now we have a variety of name spaces, file attributes, cluster
> sises, inodes and other nasty stuff that are too exposed. Suppose that
> you could add any fileds you want, any keys you want. Suppose that users
> and groups could have any number of fields. Suppose you wanted to add
> more levels like "managers" and some of the fancy Novell stuff. With a
> database the user could create any kind of an interface to access files
> that they want.

this goal is very worthwhile, but it's a lot harder than you imagine,
because of compatability, performance, security, and backwards
compatability.

<snip examples of nifty applications of the above>

> So - this is totally outside the bix thinking but use you imagination
> and envision what could be done if we lose the file system paradyme and
> embrace the SQL based data paradhyme.
>
> Will it be faster? Doing only what we are limited to today, no. Doing
> what we would be able to do, yes. This is a radically new concept and
> you should be very stoned to fully appreciate it. I just wanted to throw

lol

> the idea out there so that people can start rolling it around and
> thinking about it. It's an idea that is similar in some ways to the
> /proc filesystem where things appear as files that aren't

others have suggested that all this belongs in user-space.  hans and i
argue that point every once in a while still.  i think it comes down
to -ENOPATCH

NATE
