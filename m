Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130642AbRBLPWB>; Mon, 12 Feb 2001 10:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRBLPVv>; Mon, 12 Feb 2001 10:21:51 -0500
Received: from cse.unl.edu ([129.93.33.1]:39237 "EHLO cse.unl.edu")
	by vger.kernel.org with ESMTP id <S130642AbRBLPVn>;
	Mon, 12 Feb 2001 10:21:43 -0500
Date: Mon, 12 Feb 2001 09:21:39 -0600
From: Ben Rush <brush@cse.unl.edu>
To: linux-kernel@vger.kernel.org
Subject: Error Communicating With Module
Message-ID: <Pine.SGI.4.05.10102120911460.4669542-100000@cse.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, first of all I must tell you that I do not belong to this
mailing list as of yet, so, please respond to me via brush@cse.unl.edu.
Thank you very much in advance!

	My problem is as follows: 

	I have added a variable named bens_variable to ksyms.c as follows: 

	extern int bens_variable=10; 

	I have then exported the variable in ksyms.c as follows: 

	EXPORT_SYMBOL(bens_variable); 

	I then recompiled the kernel as bzImage and everything went
perfectly fine. I then wrote a module for that particular kernel which
is simple and looks as follows: 

	#define MODULE
	#define __KERNEL__
	#include <linux/module.h>

	int init_module(void){
		printk(bens_variable); 
		return 0; 
	}
	
	void cleanup_module(void){
		printk("<1>Module Unloaded\n"); 
	}

	But, of course, whenever I try and compile the module to load it
using gcc it tells me that bens_variable is undefined - which makes sense,
however I don't see how I can compile this without typing in 

	extern int bens_variable; 

	again. How do I get my module to compile and print out the value
of bens_variable as defined within ksyms.c? 

	Again, please respond to me via brush@cse.unl.edu. Thanks again in
advance!!!

	~Ben
	brush@cse.unl.edu

	******************************************************
		    Benjamin Rush (brush@cse.unl.edu)
			http://cse.unl.edu/~brush/
		  Undergradute Computer Scientist @ UNL
	*******************************************************


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
