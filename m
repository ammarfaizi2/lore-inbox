Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSLGLaf>; Sat, 7 Dec 2002 06:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSLGLaf>; Sat, 7 Dec 2002 06:30:35 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:19942 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262450AbSLGLae>; Sat, 7 Dec 2002 06:30:34 -0500
Message-ID: <3DF1DD6C.6040300@gmx.net>
Date: Sat, 07 Dec 2002 12:37:16 +0100
From: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Find module by name
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I want to implement a kind of module autoloading mechanism.
The situation is the following: There are two modules A and B,
where A needs module B to be loaded under certain (runtime)
conditions.

First I thought the solution would be pretty simple. I wanted to
use a function like find_module from kernel/module.c to search
module_list for a module of a certain name. If it is not there
request_module would be used to load the module and afterwards
another find_module call should return a pointer to the module
if the call succeeded.

Unfortunately this solutions does not work in general as
module_list is not exported which means that I'm getting those
nasty 'unresolved symbol' messages when insmoding module A.

Any suggestions? Thanks for your help.


Thomas

