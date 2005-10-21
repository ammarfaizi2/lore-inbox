Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVJULWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVJULWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 07:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJULWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 07:22:53 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:51036 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964832AbVJULWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 07:22:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QBD2xWFVS0b8/2A6+MRIjeX4CMibefVzEXUIC8TqHc3KuSnPb+cgjSr5ouYWlSeVobIm49mJBWNcpp3cEwFw1AY/Ad0geSKr7HgaYW2mP/9RlQdrWuRf8jrw2c5SsAyqV3UMHaNOP8uWvpLBnq/+yt0DLkoQcKSVmY2HJ/83sRI=
Message-ID: <e7aeb7c60510210422s33c0240ex4eab1d90d94111fe@mail.gmail.com>
Date: Fri, 21 Oct 2005 13:22:51 +0200
From: Yitzchak Eidus <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about code from the linux kernel development ( se ) book
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first i am very sorry if it isnt the place to ask questions like this
but i didnt know where else to ask ( i tryed irc channels and i was
send from there to this list )
anyway:
does this following code look buggy? :
DECLARE_WAITQUEUE ( wait , current );
add_wait_queue ( q , &wait );
while ( !condition ) {
set_current_stat ( TASK_INTERRUPTABLE ); i
if ( signal_pending ( current ) )
/* handle signal */
schedule ( ); }
set_current_state ( TASK_RUNNING );
remove_wait_queue ( q , &wait );
first:doesnt in the way from checking the !condition to
set_current_state  the condition can be changed no?

second:why not putting the schedule ( ); right after the
set_current_state ( ) , what the point in checking the if (
signal_pending ( ) first, if the proccess doesnt started to sleep yet?
third: in the cleaning in the way from putting the set_current_state (
TASK_RUNNING ) into remove_wait_queue , cant the queue wait list ( q )
wake up again the wait procsess?
( thnks for the help , please if it can be done answer quickly i am
tanker in the idf and need to come back to the army soon , ( no
internet there... ) )
thnks!
