Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVCHTZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVCHTZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVCHTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:24:30 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:43051 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262068AbVCHTWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:22:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=d8fN3JOfQNjx9g3SffU+ESSrXqhedPHZM26XDp3YrWH7d8JT413T9aVCJUBDRezZdsNUmEYLbxEcm4DfUpEei4nK8OzWEXYTWqVE8qLQk4aADyZgf5ACo7Pg33lFt3hBv1rvzsGXSa2EoPSavcHH0IqrnhStLT+2E+pYXQaWeKI=
Message-ID: <d91f4d0c050308112120aace61@mail.gmail.com>
Date: Tue, 8 Mar 2005 14:21:38 -0500
From: George Georgalis <georgalis@gmail.com>
Reply-To: George Georgalis <georgalis@gmail.com>
To: linux-kernel@vger.kernel.org, users@spamassassin.apache.org,
       misc@list.smarden.org, supervision@list.skarnet.org, nix@esperi.org.uk,
       mkettler@evi-inc.com
Subject: Re: a problem with linux 2.6.11 and sa
In-Reply-To: <20050308171953.GB1936@ixeon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050303214023.GD1251@ixeon.local>
	 <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2>
	 <20050303224616.GA1428@ixeon.local>
	 <871xaqb6o0.fsf@amaterasu.srvr.nix>
	 <20050308165814.GA1936@ixeon.local>
	 <20050308171953.GB1936@ixeon.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 12:19:53 -0500, George Georgalis <george@galis.org> wrote:
> On Tue, Mar 08, 2005 at 11:58:14AM -0500, George Georgalis wrote:
> >On Tue, Mar 08, 2005 at 01:37:03PM +0000, Nix wrote:
> >>On Thu, 3 Mar 2005, George Georgalis uttered the following:
> >>> I recall a problem a while back with a pipe from
> >>> /proc/kmsg that was sent by root to a program with a
> >>> user uid. The fix was to run the logging program as
> >>> root. Has that protected pipe method been extended
> >>> since 2.6.8.1?
> >>
> >>The entire implementation of pipes has been radically revised between
> >>2.6.10 and 2.6.11: see, e.g., <http://lwn.net/Articles/118750/> and
> >><http://lwn.net/Articles/119682/>.
> >>
> >>Bugs have been spotted in this area in 2.6.10: this may be
> >>another one.
> >
> >Thanks, my issue is clearly between 2.6.10 and 2.6.11; though I won't be
> >able to drill down anything more specific, for a while. The links
> >do look relevant but I cannot say for sure.

Here is a problem with 2.6.10:

while read file; do mplayer $file ; done <mediafiles.txt

or

tail -n93  mediafiles.txt | while read file; do mplayer $file ; done

for each file path in that text file I get:

Failed to open /dev/rtc: Permission denied (it should be readable by the user.)

In addition the audio pcm level is set to zero (presumably by mplayer).

This does work:
for file in `cat mediafiles.txt`; do mplayer $file ; done

but discovering and fixing code now broke will be unpleasent.
What exactly is going on? 

// George

-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
