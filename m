Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291312AbSBMCvK>; Tue, 12 Feb 2002 21:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291319AbSBMCvB>; Tue, 12 Feb 2002 21:51:01 -0500
Received: from www.webservicesolutions.com ([64.26.141.39]:5286 "HELO
	www.webservicesolutions.com") by vger.kernel.org with SMTP
	id <S291312AbSBMCu4>; Tue, 12 Feb 2002 21:50:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mark Swanson <swansma@yahoo.com>
Organization: personal
To: linux-kernel@vger.kernel.org
Subject: RFC: /proc key naming consistency
Date: Tue, 12 Feb 2002 21:50:35 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Terrehon Bowden <terrehon@pacbell.net>, Bodo Bauer <bb@ricochet.net>,
        Jorge Nerin <comandante@zaralinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020213030047.8B1FB2257B@www.webservicesolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to hear people's opinions on making the keys in the /proc 
hierarchy consistent wrt the space character. The current Linux 
Documentation/filesystems.proc.txt does not suggest any standard naming 
conventions. F.E. cat /proc/cpuinfo 
(partial list)

cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 400.907
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no

Notice the space between "cpu" and "MHz", or "cpu" and "family" yet there is 
no space between "fdiv" and "bug" (_).

The reason I think NOT using a space is a good idea because it makes life 
easier for developers parsing /proc entries. Specifically, Java developers 
could use /proc/cpuinfo as a property file, but the space in the 'key' breaks 
java.util.Properties.load(). 

Fire away...
