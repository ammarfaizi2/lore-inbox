Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWFNEWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWFNEWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 00:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFNEWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 00:22:49 -0400
Received: from 8.ctyme.com ([69.50.231.8]:23458 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932409AbWFNEWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 00:22:49 -0400
Message-ID: <448F8F18.4030200@perkel.com>
Date: Tue, 13 Jun 2006 21:22:48 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Visionary ideas for SQL file systems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to throw this idea out there just to get people thinking. 
There's nothing in reality that is like this except maybe some of the 
ReiserFS ideas, but I want to take the idea farther. the idea is ......

Why not put an SQL filesystem directly on a block devices where files 
are really blobs within the filesystem and file names and file 
attributes are all indexed data withing the SQL database. The operating 
system will have SQL built in.

Right now we have a variety of name spaces, file attributes, cluster 
sises, inodes and other nasty stuff that are too exposed. Suppose that 
you could add any fileds you want, any keys you want. Suppose that users 
and groups could have any number of fields. Suppose you wanted to add 
more levels like "managers" and some of the fancy Novell stuff. With a 
database the user could create any kind of an interface to access files 
that they want.

Picture this. When listing a directory how do we determine who gets to 
see what file names? I siggest that the rule be an SQL query that the 
system owner can configure anyway they want. That way you can set it up 
so that the users only see the file names that they have access to and 
you could emulate Linux, or you could emulate Windows, or you could 
emulate Netware, or each directory could have it's own embedded rules 
that are itself stored within the database.

Now - we hav files that we can read, write, lock, create, delete, etc. 
The file appear to be a colection of bytes, but what if they aren't 
really a collection of bytes? Suppose what appeard as a text file was 
really the output of a query that created what looks like a file but 
eack line was a record in an SQL database? Writing the file might not be 
storing bytes but rather storing rows in a database. The reading and 
writing of the file would be controlled by the files read query and 
write query, So if you want it to work like today's files then you are 
reading and writing a blob. But that would be just one of many options.

For example, if you are using an embedded query to read and write files 
the lines of one file might also be lines in a different file that has a 
query that intersects the same data. So if you write a line in one file 
you could change the corisponding line in another file that includes the 
same data element. So if your writing a program and you change the name 
of an include file then everything that references that file changes the 
moment you rename it.

A tar file wouldn't be a separate file. It might just be a query that 
creates a tar file view of other existing files. By creating a name with 
a .tar extension and pointing it to a directory makes a tar view of an 
existing directory. But you can edit the contents of the tar file by 
editing the files withing the directory that the tar query points to.

So - this is totally outside the bix thinking but use you imagination 
and envision what could be done if we lose the file system paradyme and 
embrace the SQL based data paradhyme.

Will it be faster? Doing only what we are limited to today, no. Doing 
what we would be able to do, yes. This is a radically new concept and 
you should be very stoned to fully appreciate it. I just wanted to throw 
the idea out there so that people can start rolling it around and 
thinking about it. It's an idea that is similar in some ways to the 
/proc filesystem where things appear as files that aren't

My 2 cents ....

