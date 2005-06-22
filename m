Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVFVDRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVFVDRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVFVDRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:17:41 -0400
Received: from smtpout.mac.com ([17.250.248.44]:21983 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262695AbVFVDRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:17:21 -0400
In-Reply-To: <42B8D131.6060502@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <42B831B4.9020603@pobox.com.suse.lists.linux.kernel> <42B87318.80607@namesys.com.suse.lists.linux.kernel> <20050621202448.GB30182@infradead.org.suse.lists.linux.kernel> <42B8B9EE.7020002@namesys.com.suse.lists.linux.kernel> <42B8BB5E.8090008@pobox.com.suse.lists.linux.kernel> <p73fyvbb2rh.fsf@verdi.suse.de> <42B8D131.6060502@namesys.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2B506228-9184-4323-AD22-7336E6955933@mac.com>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Tue, 21 Jun 2005 23:16:31 -0400
To: Hans Reiser <reiser@namesys.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 21, 2005, at 22:47:13, Hans Reiser wrote:
> Andi Kleen wrote:
>> and your child definitely
>> is in serious need of that to be mergeable. I'm sure Christoph is  
>> able
>> to review inpartially even when he is involved with other FS.
> As impartial as a puppy on PCP....

So where else are you planning to get a competent reviewer who is fluent
in the internals of filesystems?  Good reviewers don't grow on trees,  
and
in order to be able to understand filesystem issues, one must generally
have worked with them before...  Besides, what good is insulting others
going to do?

> Christoph is aggressive about things he does not take the time to
> understand or ask about first.
[rant snipped]

 From my objective re-reading of his posts, I can see that he is  
critical
of things that are difficult to understand not just to be critical, but
to provoke additional thought over those portions of the code.  In many
cases this leads to better abstractions and simpler code than otherwise.

> How about review by benchmark instead?

/dev/sda is a great filesystem with awesome benchmarks, assuming one  
only
needs to store a single file.  Besides, benchmarks aren't the only thing
important about code.  If the interface consists of:

   void clear_current_filename(void);
   void add_char_to_current_filename(char x);
   void read_bytes_from_current_file(char *byte, unsigned long size);
   void write_bytes_to_current_file(const char *byte, unsigned long  
size);

then this is clearly not a good API, regardless of how well or poorly it
may perform.

> It works, it runs faster than the competition, users like it, we
> addressed the core kernel patch complaints, it should go in and  
> receive
> the exposure that will result in lots of useful improvements and
> suggestions.   It seems like we are getting an unusual review process.

If you look over other patches in -mm, you will see that your review
process is not unusual, especially given the number of concerns that  
other
developers have raised over Reiser4.

[irrelevant algorithm rant snipped]

> If you guys want to understand
> what I am doing I am happy to talk about it extensively, but please
> don't require that I groupthink.  I frankly think that with my
> benchmarks, I should be allowed to tinker on my own.

Yes, you can tinker on your own all you want.  Another project that has
taken that route is GrSecurity, which was alive and well last I checked.

If you don't like others criticisms, take up your marbles and go home,
just don't expect them to accept your work when you've not fixed it to
community standards.

Cheers,
Kyle Moffett

--
Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz

